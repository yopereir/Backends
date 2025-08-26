import torch
import torch.nn as nn
import torch.optim as optim
import torchvision
import torchvision.transforms as transforms
import mlflow
import mlflow.pytorch
import itertools

# =========================
# 1. Setup MLflow
# =========================
mlflow.set_tracking_uri("http://127.0.0.1:5000")
mlflow.set_experiment("pytorch-hpo-example")

# =========================
# 2. Define Model Factory
# =========================
class SimpleNN(nn.Module):
    def __init__(self, hidden_size=128):
        super(SimpleNN, self).__init__()
        self.fc1 = nn.Linear(28*28, hidden_size)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(hidden_size, 10)

    def forward(self, x):
        x = x.view(-1, 28*28)
        x = self.fc1(x)
        x = self.relu(x)
        x = self.fc2(x)
        return x

# =========================
# 3. Data
# =========================
transform = transforms.Compose([transforms.ToTensor()])

trainset = torchvision.datasets.MNIST(root="./data", train=True, download=True, transform=transform)
trainloader = torch.utils.data.DataLoader(trainset, batch_size=64, shuffle=True)

testset = torchvision.datasets.MNIST(root="./data", train=False, download=True, transform=transform)
testloader = torch.utils.data.DataLoader(testset, batch_size=1000, shuffle=False)

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# =========================
# 4. Training Function
# =========================
def train_and_evaluate(lr, hidden_size, epochs=3):
    model = SimpleNN(hidden_size=hidden_size).to(device)
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=lr)

    with mlflow.start_run():
        # Log hyperparams
        mlflow.log_param("learning_rate", lr)
        mlflow.log_param("hidden_size", hidden_size)
        mlflow.log_param("epochs", epochs)

        # Training loop
        for epoch in range(epochs):
            running_loss = 0.0
            for inputs, labels in trainloader:
                inputs, labels = inputs.to(device), labels.to(device)
                optimizer.zero_grad()
                outputs = model(inputs)
                loss = criterion(outputs, labels)
                loss.backward()
                optimizer.step()
                running_loss += loss.item()

            avg_loss = running_loss / len(trainloader)
            mlflow.log_metric("train_loss", avg_loss, step=epoch)
            print(f"[lr={lr}, hidden={hidden_size}] Epoch {epoch+1}, Loss: {avg_loss:.4f}")

        # Evaluation
        correct, total = 0, 0
        with torch.no_grad():
            for inputs, labels in testloader:
                inputs, labels = inputs.to(device), labels.to(device)
                outputs = model(inputs)
                _, predicted = torch.max(outputs.data, 1)
                total += labels.size(0)
                correct += (predicted == labels).sum().item()

        accuracy = 100 * correct / total
        mlflow.log_metric("accuracy", accuracy)
        print(f"[lr={lr}, hidden={hidden_size}] Accuracy: {accuracy:.2f}%")

        # Log the model
        # Use a proper input_example for MLflow
        input_example = torch.rand(1, 1, 28, 28).numpy()
        mlflow.pytorch.log_model(model, name="model", input_example=input_example)


# =========================
# 5. Hyperparameter Search
# =========================
learning_rates = [0.01, 0.001]
hidden_sizes = [64, 128, 256]

for lr, hidden in itertools.product(learning_rates, hidden_sizes):
    train_and_evaluate(lr, hidden, epochs=3)
