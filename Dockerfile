# Use the official Python image from the Docker Hub
FROM python:3.11-slim

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the current directory contents (your app files) into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Install GF (Grammatical Framework)
RUN apt-get update && apt-get install -y wget gnupg \
    && wget -qO - https://www.grammaticalframework.org/releases/apt/gf-signing-key.asc | apt-key add - \
    && echo "deb [arch=amd64] https://www.grammaticalframework.org/releases/apt stable main" > /etc/apt/sources.list.d/gf.list \
    && apt-get update && apt-get install -y gf

# Expose port 8080 for the app
EXPOSE 8080

# Define environment variable for Flask
ENV FLASK_APP=app.py

# Run the application
CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]
