
# ⚡️ Docker-Ansible-Nginx-Wordpress-Packer-Terraform-AWSECS ⚡️ 

## Tools used

- Docker
- Ansible
- Packer
- Terraform

## Frameworks & Services used

- Nginx
- Wordpress
- AWS
    - ECS
    - EC2
    - RDS
    - ELB
    - IAM

## Project Division

1. Packer setup
2. Terraform setup

## What i have done :

### 1. Packer setup

- Created a base docker alpine linux image ` afiffing/ansible:latest` with ansible installed in it.

- Dockerfile for `afiffing/ansible:latest` is shown below

```
FROM alpine:latest
MAINTAINER "Ashish Singh" <afiffing@gmail.com>
 
RUN set -ex && \
  buildDeps="python-dev build-base libffi-dev openssl-dev" && \
  apk add --no-cache $buildDeps python py-pip ca-certificates bash && \
  pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir ansible && \
  apk del --purge $buildDeps

CMD ["ansible"]
```

- Using the same image `afiffing/ansible:latest` in my [packer.json](https://github.com/afiffing/wp-docker-ansible-terraform-ecs/blob/master/packer/packer.json) file.

- Using previously installed `ansible` in the above mentioned docker image, `nginx` and `wordpress` has been installed and configured.

- Apart from nginx, wordpress and their dependencies.I am using [supervisord](https://github.com/afiffing/wp-docker-ansible-terraform-ecs/tree/master/packer/ansible/roles/supervisord) for initiating multiple process at the boot-up of the container. Read more about [supervisord](http://supervisord.org/).

- Newly configured running container has been pushed to [dockerhub](https://hub.docker.com/).

- Now, terraform will use this new image `afiffing/ansible-nginx-wordpress:1.1` for aws ecs [task-definitions](https://github.com/afiffing/wp-docker-ansible-terraform-ecs/blob/master/terraform/task-definitions/wordpress.json)

### 2. Terraform setup

#### IAM roles & policies

- In order to deploy AWS ECS with EC2 ( ECS instances ).
    - For EC2 config used [here](https://github.com/afiffing/wp-docker-ansible-terraform-ecs/blob/master/terraform/ec2.tf) : `ecsInstanceRole` :
```
{
"Version": "2012-10-17",
"Statement": [
{
 "Effect": "Allow",
 "Action": [
   "ecs:CreateCluster",
   "ecs:DeregisterContainerInstance",
   "ecs:DiscoverPollEndpoint",
   "ecs:Poll",
   "ecs:RegisterContainerInstance",
   "ecs:StartTelemetrySession",
   "ecs:UpdateContainerInstancesState",
   "ecs:Submit*",
   "ecr:GetAuthorizationToken",
   "ecr:BatchCheckLayerAvailability",
   "ecr:GetDownloadUrlForLayer",
   "ecr:BatchGetImage",
   "logs:CreateLogStream",
   "logs:PutLogEvents"
 ],
 "Resource": "*"
}]}

```
- Similary `ecsServiceRole` for ECS configuration described here

```
  {
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
              "ecs:CreateCluster",
              "ecs:DeregisterContainerInstance",
              "ecs:DiscoverPollEndpoint",
              "ecs:Poll",
              "ecs:RegisterContainerInstance",
              "ecs:StartTelemetrySession",
              "ecs:Submit*",
              "ecs:StartTask",
              "ecr:GetAuthorizationToken",
              "ecr:BatchCheckLayerAvailability",
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchGetImage",
              "ec2:AuthorizeSecurityGroupIngress",
              "ec2:Describe*",
              "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
              "elasticloadbalancing:DeregisterTargets",
              "elasticloadbalancing:RegisterTargets",
              "elasticloadbalancing:Describe*",
              "elasticloadbalancing:RegisterInstancesWithLoadBalancer"
          ],
          "Resource": "*"
          }
        ]
      }
  
```     

#### How to run this project

- In order to run it you have to run two commands one by one. `packer build packer.json`, It will configure wordpress with nginx, waiting to get deployed over `AWS EC2`.

- Secondly, run terraform to deploy configured docker image on `AWS ECS`.I am passing required credentials on runtime via `CLI`.

- First a dry run for terraform, pretty useful in debugging.
```
terraform plan -var 'aws_access_key=yourkey' -var 'aws_secret_key=yourpasskey' -var 'key_name=keypairnameforec2instance' -var 'db_password="password-for-mysqluser"' -var 'wp_password="password-for-wordpressadmin"' -var 'wp_mail=emailaddress' 
```

- Now, run terraform.

```
terraform apply -var 'aws_access_key=yourkey' -var 'aws_secret_key=yourpasskey' -var 'key_name=keypairnameforec2instance' -var 'db_password="password-for-mysqluser"' -var 'wp_password="password-for-wordpressadmin"' -var 'wp_mail=emailaddress' 
```

- Now it will list you out an IP address and a load balancer (`AWS ELB`) domain name.

- Access any of them to go to wordpress website.

### How components interact between each over.

- I have tried to show the components connectivity via a flow diagram.

![Alt text](https://github.com/afiffing/wp-docker-ansible-terraform-ecs/blob/master/components.jpg "Screenshot")

#### How you would have done things to have the best HA/automated architecture?.
#### Share with us any ideas you have in mind to improve this kind of infrastructure?.
```
Tomorrow we want to put this project in production. What would be your advices and choices to achieve that.
Regarding the infrastructure itself and also external services like the monitoring, ...
```
- For this project, Various tools are infused in the setup which is not required. I understand that it was meant to check my understanding and capabilities.
    
    - #### Proposed Solution for HA/automated architecture or a production ready environment

        - ##### Proposed Solution with RDS

            - Wordpress Docker Container from hub.docker.com
            - Multi-AZ RDS
            - Terraform 
            - ELB with HTTPS/SSL
            - AWS Cloudwatch alarms with AWS SES and AWS SNS for monitoring and mailer notifications.
            - Auto Scaling Group with Autoscaling policies (up and down), for usage demands.
            - Static content and assests( CSS, JS) on S3 for AWS Cloudfront (CDN) 
            - Route53 for DNS 
            - CI/CD : Deployment Immutable deployment stategy: Jenkins Pipeline. ( Build/Test->Stage->Test->Prod)



        - ##### Proposed Solution without RDS

            - Wordpress Docker Container from hub.docker.com
            - Mysql Docker Container & Docker Compose + ECS container registery for Mysql and Wordpress Container.
            - Terraform 
            - ELB with HTTPS/SSL
            - AWS Cloudwatch alarms with AWS SES and AWS SNS for monitoring and mailer notifications.
            - Auto Scaling Group with Autoscaling policies (up and down), for usage demands
            - Static content and assests( CSS, JS) on S3 for AWS Cloudfront (CDN) 
            - Route53 for DNS 
            - CI/CD : Deployment Immutable deployment stategy: Jenkins Pipeline. ( Build/Test->Stage->Test->Prod)


#### About External Monitoring services.

- Though AWS Cloudwatch is self sufficient in many ways, but since you have asked specifically for external services, i have datadog and Zabbix and monit as a consideration.
- Though i prefer Zabbix, Since Zabbix is an independent tool when it comes to multiple cloud vendors, also an open-source project, it's the best fit and efficiently serves my purpose. 
- One quick look up upon all those running servers, about their running status in a single dashboard.
- Also, it's quite popular in the open-source community, feasible API, Plugins & integration compatibility with other available resources in the market.
