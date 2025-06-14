# AwsLayers program by Nick 👩‍💻
This is a small shell (bash) program that downloads python libraries for you and converts them to a lambda layer.

# Steps 🔨
- Upload your requirements.txt file in a bucket. Be aware that the library size **CAN NOT EXCEED 250mb**.
- Go to the iam-policy.json file and place in the "recourse" key of the second object the arn of the bucket in which you uploaded the requirements.txt file.
- Create an IAM role that has attached the policy I uploaded (iam-policy.json).
- Start an EC2 instance that has the role equipped.
- Modify the parameters of the shell script:
    1) PYTHON_VERSION: Specify the python version (3.11 or 3.12  <11 or >12 creates problems with yum install)
    2) S3_PATH_TO_REQUIREMENTS: Specify the URI of the requirements.txt file
    3) LAYER_NAME: Specify the name of the layer you want to create
- Type `bash Script.sh` in your shell and then the lambda layer will be created.

### Thank you for using my program! 😊
Any suggestions would be much appreciated!
