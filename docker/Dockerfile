FROM python:3.9.18-alpine3.18

#update, install curl, git, zip/unzip
RUN apk  update \
    && apk add --no-cache bash \
    && apk add "aws-cli=2.13.5-r0" \
    && apk add curl zip git unzip iputils \
    && pip install --no-cache-dir boto3


#create/change woorking directory
WORKDIR /home/app

#copy all files
COPY ../python/aws-secrets-manager.py .

CMD ["tail", "-f", "/dev/null"]