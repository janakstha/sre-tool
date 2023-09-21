#!/usr/bin/env python3.9

import boto3

def check_ecr_images(input_file):
    # Read the input file to get repository names and image tags
    # sample input file sdm/webservices:1.82.0-418
    with open(input_file, 'r') as file:
        lines = file.readlines()

    # Initialize the ECR client
    ecr_client = boto3.client('ecr')

    for line in lines:
        # Split each line into repository and image tag
        repository_name, image_tag = line.strip().split(':')

        # Describe the ECR image to check if it exists
        try:
            response = ecr_client.describe_images(
                registryId='437291019013',
                repositoryName=repository_name,
                imageIds=[
                    {
                        'imageTag': image_tag
                    },
                ],
                filter={'tagStatus': 'TAGGED'}  # Only list tagged images
            )
            image_details = response['imageDetails'][0]
            # print(f"{response}")
            print(f"Image in repository '{repository_name}' with tag '{image_tag}' exists.")
            # print(f"Image in repository {image_details['registryId']}.dkr.ecr.eu-central-1.amazonaws.com/{repository_name}:{image_tag} exists.")
            print(f"Image Digest: {image_details['imageDigest']}")
            print(f"Image Pushed At: {image_details['imagePushedAt']}\n")

        except ecr_client.exceptions.ImageNotFoundException:
            print("###### WARNING ######")
            print(f"Image in repository '{repository_name}' with tag '{image_tag}' does not exist.\n")
            print("###### WARNING ######\n")

if __name__ == "__main__":
    input_file = "./prod-container-image-list.txt"  # Replace with the path to your input file
    check_ecr_images(input_file)

