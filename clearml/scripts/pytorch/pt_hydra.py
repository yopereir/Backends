# prereqs: python -m pip install hydra-core --upgrade
import hydra
from omegaconf import DictConfig, OmegaConf
from clearml import Task

@hydra.main(version_base=None, config_path="conf", config_name="config")
def my_app(cfg : DictConfig) -> None:
    task = Task.init(project_name="Hydra examples", task_name="Hydra configuration")
    logger = task.get_logger()
    logger.report_text("You can view your full hydra configuration under Configuration tab in the UI")
    print(OmegaConf.to_yaml(cfg))

if __name__ == "__main__":
    my_app()