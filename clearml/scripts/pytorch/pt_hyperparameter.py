import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
from torchvision import datasets, transforms
from torch.utils.data import DataLoader

from clearml import Task

# --- Step 1: Initialize ClearML Task ---
task = Task.init(project_name="pytorch_demo", task_name="base_training")

# --- Step 2: Define hyperparameters and connect them to ClearML ---
config = {
    "batch_size": 64,
    "lr": 0.01,
    "epochs": 5,
}
config = task.connect(config)  # <--- ClearML will track these!

print("Hyperparameters:", config)

# --- Step 3: Define dataset loaders ---
transform = transforms.Compose([transforms.ToTensor()])

train_dataset = datasets.MNIST("./data", train=True, download=True, transform=transform)
val_dataset = datasets.MNIST("./data", train=False, download=True, transform=transform)

train_loader = DataLoader(train_dataset, batch_size=config["batch_size"], shuffle=True)
val_loader = DataLoader(val_dataset, batch_size=config["batch_size"], shuffle=False)


# --- Step 4: Define a simple model ---
class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.fc1 = nn.Linear(28 * 28, 128)
        self.fc2 = nn.Linear(128, 10)

    def forward(self, x):
        x = x.view(-1, 28 * 28)
        x = F.relu(self.fc1(x))
        return self.fc2(x)


model = Net()
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr=config["lr"])


# --- Step 5: Training loop ---
logger = task.get_logger()

for epoch in range(config["epochs"]):
    model.train()
    running_loss = 0.0
    for images, labels in train_loader:
        optimizer.zero_grad()
        outputs = model(images)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
        running_loss += loss.item()

    avg_loss = running_loss / len(train_loader)
    logger.report_scalar("loss", "train", avg_loss, iteration=epoch)

    # --- Step 6: Validation ---
    model.eval()
    correct = 0
    total = 0
    with torch.no_grad():
        for images, labels in val_loader:
            outputs = model(images)
            _, predicted = torch.max(outputs.data, 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()

    accuracy = correct / total
    logger.report_scalar("accuracy", "validation", accuracy, iteration=epoch)

    print(f"Epoch {epoch+1}/{config['epochs']} - Loss: {avg_loss:.4f}, Validation Accuracy: {accuracy:.4f}")

print("Training complete!")
