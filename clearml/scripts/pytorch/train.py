# Prereqs: python -m pip install clearml torch torchvision
from clearml import Task, OutputModel
import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import datasets, transforms

# Create a new task (this links your script to the ClearML server/dashboard)
task = Task.init(
    project_name="PyTorch Experiments",
    task_name="ResNet Training",
    task_type=Task.TaskTypes.training  # optional, helps categorize
)

# ClearML Task already created above
logger = task.get_logger()

# Simple model
class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.fc1 = nn.Linear(28*28, 128)
        self.fc2 = nn.Linear(128, 10)

    def forward(self, x):
        x = x.view(-1, 28*28)
        x = torch.relu(self.fc1(x))
        return self.fc2(x)

# Data
train_loader = torch.utils.data.DataLoader(
    datasets.MNIST("./data", train=True, download=True,
                   transform=transforms.ToTensor()),
    batch_size=64, shuffle=True
)

# Model, loss, optimizer
model = Net()
criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=0.001)

# Training loop
for epoch in range(5):
    total_loss = 0
    for data, target in train_loader:
        optimizer.zero_grad()
        output = model(data)
        loss = criterion(output, target)
        loss.backward()
        optimizer.step()
        total_loss += loss.item()

    avg_loss = total_loss / len(train_loader)
    
    # Report metrics to ClearML
    logger.report_scalar("Loss", "train", avg_loss, epoch)
    print(f"Epoch {epoch}, Loss: {avg_loss}")

# Upload model checkpoint
torch.save(model.state_dict(), "model.pth")
task.upload_artifact("final_model", "model.pth")

# Register an output model
output_model = OutputModel(task=task, framework="pytorch")

# After training:
output_model.update_weights("model.pth")
