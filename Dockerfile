# Use Python 3.12 official image
FROM python:3.12

# Set the working directory in the container
WORKDIR /app

# Set environment variables to avoid permission errors with Hugging Face cache
ENV HF_HOME=/app/.cache

# Create the cache directory
RUN mkdir -p /app/.cache && chmod -R 777 /app/.cache

# Copy the requirements file and install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade -r requirements.txt
RUN pip uninstall -y pinecone-plugin-inference

# Copy the rest of the application code
COPY . /app

# Command to run the application using Flask
CMD ["flask", "run", "--host=0.0.0.0", "--port=7860"]
