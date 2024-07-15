The backend Java application is containerized using Docker. A multi-stage build process is employed to create a small and secure final image, which is then stored in Amazon ECR.

- CI Pipeline: Triggered automatically upon a push to the backend repository. The pipeline builds the application, runs tests, and pushes the Docker image to ECR.
- Manual Deployment Pipeline: Allows managers to control when new versions are deployed to production. This can be automated in the future if manual intervention is deemed unnecessary.
- We have used some repository secrets to execute the github actions pipeline, such as AWS_ACCOUNTD_ID, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_REGION. These values has to be added accordingly before executing the pipeline.