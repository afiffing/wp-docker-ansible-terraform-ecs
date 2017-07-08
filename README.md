 wp-docker-ansible-terraform-ecs
 
  
*  What i have done
     Packer ansible wordpress docker setup
    1) created a docker baseimage with ansible installed in it, pushed the same to dockerhub.
    2) Tried to setup wordpress using the base image defined, got stucked with ansible unarchive of wordpress installation, Work around downloaded and installed wordpress in the same base image. Same update docker base image made public again. 
    3) At this stage i have packer build of a docker image with ansible,nginx webserver and wordpress installed in it.
    4) All i have to do is to deploy the same setup on ECS via terraform.
    5) Configured terraform to create 1 ELB 1 ECS 1 EC2 instance, with security groups for newly created Ec2 instance and for the Elb. 
       No i already had a RDS mysql running in my free tier account hence didn't create a new one. Same with VPC, routetable and internet gteway, didn't want to disturb my current setup. Neither want to use my official account, as it will be visible in the billing cycle.

    
  * How run your project
    In order to run it you have to just access ELB DNS : wp-elb-tf-2140778452.us-west-2.elb.amazonaws.com

  * How components interact between each over
    ECS -- has container ( docker based images configured to used accordingly here) that needs to be running over Ec2 instance, Now docker base image has nginx and wordpress installed. Ansible make sure that it's task directories have their templates placed as required.
   
   RDS mysql db connections and wordpress wp_config entry are done in runtime via terraform json file.

  * What problems did you have
    First problem i had with ansible unarchive of wordpress.tar.gz file, overcame that with an preinstalled wordpress docker image.
    Secondly, after completing terraform setup, i forgot to register aws ECR, i.e. container registry, that's a very subtle step which costs me some time. Fixed it.
    Ecs with ELB requires a EC2servicecontainer IAM role with sufficient permissions i.e. AmazonEC2ContainerServiceRole, otherwise terraform woun't be able to roll out ecs clusters with services.
    Set up is incomplete, as for now ELB has no registered instance with it, hence ECS shows this error : service wp-ecs-svc-tf was unable to place a task because no container instance met all of its requirements. Reason: No Container Instances were found in your cluster.
    
  * How you would have done things to have the best HA/automated architecture
    Due to time limitation, as i work on saturdays as well. I have been able to configure this setup to till this stage. 
    For the same deployment i could have gone to packer ansible docker and aws cli setup. No doubt Terraform is such a powerful tool.But  what i have felt while configuring it, is that we really don't need all these tools. It's somehow increasing an unwanted complexity in the entire process.Though i couldn't complete it in time, because of obvious reasons.

  * Share with us any ideas you have in mind to improve this kind of infrastructure.
   Like i have said, less number of external tools could have made the job easier and fast. Currently it's doable, but can be done with much more ease. 
    As of now i have hard coded some of the variable in the configuration files, that can be easily be avoided.
    All these repositories are public : docker and git, vpc's should have been privately configured.
    Entire set up hasss single entities overall, 1 RDS, 1 ELB With single EC2, Single ECS cluster. This is not favoirabble for production scenario. Multi-AZ RDS, More than one Ec2 instance and ECS cluster configuration.
  

  * About External Monitring services.
   Though Cloudwatch is self sufficient in many ways, but since you have asked specifically for external services, i have datadog and Zabbix and nagios as a consideration.
 


