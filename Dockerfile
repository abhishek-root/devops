# ---- Stage 1: Build dependencies ----
FROM python:3.11-slim AS build

# Set working directory
WORKDIR /app

# Copy dependency files
COPY requirements.txt .

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc build-essential \
    && pip install --upgrade pip \
    && pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt

# ---- Stage 2: Final Image ----
FROM python:3.11-slim

WORKDIR /app

# Create a non-root user
RUN useradd --create-home appuser

# Copy app code and built wheels
COPY --from=build /wheels /wheels
COPY . /app

# Install from pre-built wheels
RUN pip install --no-index --find-links=/wheels -r requirements.txt \
    && chown -R appuser:appuser /app

USER appuser

EXPOSE 8000

# Command to run FastAPI app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
