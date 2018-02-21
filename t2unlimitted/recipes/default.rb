#
# Cookbook:: t2unlimitted
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

bash 'extract_module' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
          yum update aws-cli -y
          INSTANCE_ID=`curl http://169.254.169.254/latest/meta-data/instance-id`
          REGION=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's/.$//'`
          SPECIFICATIONS_JSON="[{\"InstanceId\": \"${INSTANCE_ID}\",\"CpuCredits\": \"unlimited\"}]"
          echo "INSTANCE_ID: ${INSTANCE_ID}"
          echo "REGION: ${REGION}"
          echo "SPECIFICATIONS_JSON: ${SPECIFICATIONS_JSON}"
          aws --region ${REGION} ec2 describe-instance-credit-specifications --instance-id ${INSTANCE_ID}
          aws --region ${REGION} ec2 modify-instance-credit-specification --instance-credit-specification "${SPECIFICATIONS_JSON}"
          aws --region ${REGION} ec2 describe-instance-credit-specifications --instance-id ${INSTANCE_ID}
          EOH
end
