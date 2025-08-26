import torch
import torch.nn as nn
import torch.optim as optim
import torchvision
import torchvision.transforms as transforms
import mlflow
import mlflow.pytorch

# =========================
# 1. MLflow Setup
# =========================
mlflow.set_tracking_uri("http://localhost:5000")  # use K8s service name
mlflow.set_experiment("pytorch-mnist-example")

# =========================
# 2. Define Model
# =========================
class SimpleNN(nn.Module):
    def __init__(self):
        super(SimpleNN, self).__init__()
        self.fc1 = nn.Linear(28*28, 128)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(128, 10)

    def forward(self, x):
        x = x.view(-1, 28*28)
        x = self.fc1(x)
        x = self.relu(x)
        x = self.fc2(x)
        return x

# =========================
# 3. Load Data
# =========================
transform = transforms.Compose([transforms.ToTensor()])
trainset = torchvision.datasets.MNIST(root="/tmp/data", train=True, download=True, transform=transform)
trainloader = torch.utils.data.DataLoader(trainset, batch_size=64, shuffle=True)

testset = torchvision.datasets.MNIST(root="/tmp/data", train=False, download=True, transform=transform)
testloader = torch.utils.data.DataLoader(testset, batch_size=1000, shuffle=False)

# =========================
# 4. Training Loop
# =========================
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = SimpleNN().to(device)
criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=0.001)

with mlflow.start_run() as run:
    # Log hyperparameters
    mlflow.log_param("optimizer", "Adam")
    mlflow.log_param("learning_rate", 0.001)
    mlflow.log_param("epochs", 5)

    for epoch in range(5):
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
        print(f"Epoch {epoch+1}, Loss: {avg_loss:.4f}")

    # =========================
    # 5. Evaluate
    # =========================
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
    print(f"Test Accuracy: {accuracy:.2f}%")

    # =========================
    # 6. Log Model
    # =========================
    # Use a proper input_example for MLflow
    input_example = torch.rand(1, 1, 28, 28).numpy()
    mlflow.pytorch.log_model(model, name="model", input_example=input_example)

print("Training finished. Logged to MLflow.")
