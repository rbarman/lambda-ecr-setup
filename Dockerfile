# Use the official AWS Lambda Python 3.11 base image
FROM public.ecr.aws/lambda/python:3.11

# Install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy function code
COPY src/ ${LAMBDA_TASK_ROOT}/

# Set the Lambda function handler
CMD ["lambda_function.lambda_handler"]
