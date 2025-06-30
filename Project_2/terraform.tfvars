# project_id_1 = "terraform-gcp-463406"
project_id_2 = "terraform-gcp-2-464005"
zone = "asia-southeast1-a"
region = "asia-southeast1"
# credentials_1 = "/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/creds.json"
credentials_2 = "/home/atlantis/.atlantis/repos/yashwanthm998/atlantis/cred2.json"

# project_selector = "project2"


module_selector = {
bucket = {
    enable =false
    instance = [{
        bucket_name = "gcloud-bucket-using-tl1-p2"
        bucket_zone_location = "asia-southeast1"
        storage_class = "STANDARD"
        image_name = "sample_image"
        image_source = "image1.png"
    },
    # {
    #     bucket_name = "gcloud-bucket-using-tl2-p2"
    #     bucket_zone_location = "asia-southeast1"
    #     storage_class = "STANDARD"
    #     image_name = "sample_image"
    #     image_source = "image1.png"
    # },
    {
        bucket_name = "gcloud-bucket-using-t3-p2"
        bucket_zone_location = "asia-southeast1"
        storage_class = "STANDARD"
        image_name = "sample_image"
        image_source = "image1.png"
    }]
} 
vm = {
    enable = false
    instance = {
      vm_name = "gcloud-vm-using-atlantis-p2"
      machine_type = "e2-standard-4"
      network      = "custom-vpc-tf"
      subnetwork   = "custom-subnet"
      ssh-key =  "/Users/yashwanthm/.ssh/ansible_demo_rocky.pub"
    }
  }

vpc = {
    enable =  false
    instance = {
        network_name = "gcloud-network-using-atlantis-p2"
        subnet_name = "atlantis-subnetwork"
        ip = "10.1.0.0/24"
        firewall_name = "gcloud-firewall-atlantis"
    }
}
sa = {
    enable = false
    instance = {
        account_id = "demo123p2"
        display_name = "Service account"
    }
}
}