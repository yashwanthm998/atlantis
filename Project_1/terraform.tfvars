project_id_1 = "terraform-gcp-463406"
project_id_2 = "terraform-gcp-2-464005"
zone = "asia-southeast1-a"
region = "asia-southeast1"
credentials_1 = "/home/atlantis/.atlantis/creds.json"
credentials_2 = "/home/atlantis/.atlantis/cred2.json"
project_selector = "project2"

module_selector = {
bucket = {
    enable =false
    instance = {
        bucket_name = "gcloud-bucket-using-tl123-p1"
        bucket_zone_location = "asia-southeast1"
        storage_class = "STANDARD"
        image_name = "sample_image"
        image_source = "image1.png"
    }
} 
vm = {
    enable = true
    instance = [{
      vm_name = "gcloud-vm-using-atlantis-p1"
      machine_type = "e2-standard-4"
      network      = "custom-vpc-tf"
      subnetwork   = "custom-subnet"
      image = "rocky-linux-9-v20250611"
      username = "rocky" },
    # {
    #   vm_name = "gcloud-vm2-using-atlantis-p1"
    #   machine_type = "e2-standard-4"
    #   network      = "custom-vpc-tf"
    #   subnetwork   = "custom-subnet"
    #   image = "ubuntu-os-cloud/ubuntu-2204-lts"
    #   username = "ubuntu"
    # },
    {
      vm_name = "gcloud-vm3-using-atlantis-p1"
      machine_type = "e2-standard-4"
      network      = "custom-vpc-tf"
      subnetwork   = "custom-subnet"
      image = "centos-cloud/centos-stream-9"
      username = "centos"
    }]

  }

vpc = {
    enable =  false
    instance = {
        network_name = "gcloud-network-using-atlantis-p1"
        subnet_name = "atlantis-subnetwork"
        ip = "10.1.0.0/24"
        firewall_name = "gcloud-firewall-atlantis"
    }
}
sa = {
    enable = false
    instance = {
        account_id = "demo123p1"
        display_name = "Service account"
    }
}
}