# Use the official Python image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install any needed dependencies specified in requirements.txt

COPY requirements.txt /app

RUN pip install -r requirements.txt

# Copy the Python script into the container

COPY . .

# Expose port 5000 to the outside world
EXPOSE 5000

# Keep the container running in the background
ENTRYPOINT ["/bin/sh", "-c", "sleep 1d"]

# Run the Python script when the container launches
CMD ["python", "main.py"]

