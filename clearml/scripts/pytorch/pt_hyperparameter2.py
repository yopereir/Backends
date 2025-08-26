from clearml import Task
from clearml.automation import UniformParameterRange, UniformIntegerParameterRange, HyperParameterOptimizer
from clearml.automation.optuna import OptimizerOptuna

# Connect to ClearML
task = Task.init(project_name="pytorch-hpo", task_name="pytorch_hpo_controller")

# Base task ID from your first training run
base_task_id = "3dd78eb0906943fe920cec481286276b" # Insert TASK_ID here

# Define hyperparameter search space
optimizer = HyperParameterOptimizer(
    base_task_id=base_task_id,
    hyper_parameters=[
        UniformIntegerParameterRange("General/batch_size", 32, 128),
        UniformParameterRange("General/lr", 0.0001, 0.1),
    ],
    objective_metric_title="accuracy",        # match metric logged in training
    objective_metric_series="validation",     # match metric series
    objective_metric_goal="max",              # older versions accept string
    optimizer_class=OptimizerOptuna,
    max_iteration=10,          # number of experiments
    max_iteration_per_job=1,   # iterations per experiment
    total_max_jobs=10,         # total jobs limit
)

# Set time limit (positional argument only)
optimizer.set_time_limit(60 * 10)  # 10 minutes

# Start HPO
optimizer.start()
optimizer.wait()
optimizer.stop()
