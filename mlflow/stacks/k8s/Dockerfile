# Use official Python slim image
FROM python:3.11-slim

# Install MLflow and PyTorch
RUN pip install --no-cache-dir mlflow[extras] torch torchvision

# Set a working directory (optional, just for running code)
WORKDIR /app

# Ensure the working directory is writable, though MLflow will use /mlruns
RUN mkdir -p /app && chmod -R 0777 /app
RUN mkdir -p /mlruns && chmod -R 0777 /mlruns

# Environment variables for MLflow (optional defaults)
ENV MLFLOW_BACKEND_STORE_URI=sqlite:////mlruns/mlflow.db
ENV MLFLOW_ARTIFACT_ROOT=/mlruns
ENV MLFLOW_PORT=5000

# Expose MLflow server port
EXPOSE 5000

# MLflow server entrypoint
CMD ["mlflow", "server", \
     "--host", "0.0.0.0", \
     "--port", "5000"]
