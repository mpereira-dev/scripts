#!/bin/bash

# Get account information for the current user.
function aws-whoami {
    aws sts get-caller-identity | jq
}

# Get the id for a key by name.
function aws-get-key-id {
    local KEY_NAME=$1;
    aws ec2 describe-key-pairs --filters Name=key-name,Values=$KEY_NAME --query KeyPairs[*].KeyPairId --output text
}

# Get the PEM file for a key by name.
function aws-get-key-pem {
    local KEY_NAME=$1;
    local KEY_ID=$(aws-get-key-id $KEY_NAME)
    echo "Getting PEM file for key pair [ $KEY_NAME ] with id [ $KEY_ID ]."
    aws ssm get-parameter --name /ec2/keypair/$KEY_ID --with-decryption --query Parameter.Value --output text > $KEY_NAME.pem
    echo "PEM file saved to [ $KEY_NAME.pem ]."
}

# Decode an authorization message.
function aws-decode {
    aws sts decode-authorization-message --encoded-message $1 | jq '.DecodedMessage | fromjson' > error-message.json
}

# Get a list of outputs for the given stack.
function aws-get-stack-outputs {
    local STACK_NAME=$1
    aws cloudformation describe-stacks --stack-name $STACK_NAME | jq '.Stacks | .[] | .Outputs'
}

# Get a list of outputs for the given stack with just the key and value.
function aws-get-stack-outputs-trimmed {
    local STACK_NAME=$1
    aws cloudformation describe-stacks --stack-name $STACK_NAME | jq '.Stacks | .[] | .Outputs | reduce .[] as $i ({}; .[$i.OutputKey] = $i.OutputValue)'
}

# Get a list of outputs for the given stack with the export name and value.
function aws-get-stack-outputs-mapped {
    local STACK_NAME=$1
    aws cloudformation describe-stacks --stack-name $STACK_NAME | jq '.Stacks | .[] | .Outputs | reduce .[] as $i ({}; .[$i.ExportName] = $i.OutputValue)'
}

# List the CodeCommit repositories.
function aws-repos {
    aws codecommit list-repositories;
}

# Clone a CodeCommit Git Repository.
function aws-clone {
    local GIT_REPO=$1;
    git clone codecommit::$AWS_REGION://$AWS_PROFILE@$GIT_REPO;
}

# Add a CodeCommit Git repository as a remote.
function aws-remote-add {
    local GIT_REPO=$1;
    git remote add $GIT_REPO codecommit::$AWS_REGION://$AWS_PROFILE@$GIT_REPO
}

# Find VPC dependencies that need to be cleaned up before the VPC can be deleted.
function aws-find-dependencies {    
    local vpc=$1
    local region=$2
    aws ec2 describe-internet-gateways --region $region --filters 'Name=attachment.vpc-id,Values='$vpc | grep InternetGatewayId
    aws ec2 describe-subnets --region $region --filters 'Name=vpc-id,Values='$vpc | grep SubnetId
    aws ec2 describe-route-tables --region $region --filters 'Name=vpc-id,Values='$vpc | grep RouteTableId
    aws ec2 describe-network-acls --region $region --filters 'Name=vpc-id,Values='$vpc | grep NetworkAclId
    aws ec2 describe-vpc-peering-connections --region $region --filters 'Name=requester-vpc-info.vpc-id,Values='$vpc | grep VpcPeeringConnectionId
    aws ec2 describe-vpc-endpoints --region $region --filters 'Name=vpc-id,Values='$vpc | grep VpcEndpointId
    aws ec2 describe-nat-gateways --region $region --filter 'Name=vpc-id,Values='$vpc | grep NatGatewayId
    aws ec2 describe-security-groups --region $region --filters 'Name=vpc-id,Values='$vpc | grep GroupId
    aws ec2 describe-instances --region $region --filters 'Name=vpc-id,Values='$vpc | grep InstanceId
    aws ec2 describe-vpn-connections --region $region --filters 'Name=vpc-id,Values='$vpc | grep VpnConnectionId
    aws ec2 describe-vpn-gateways --region $region --filters 'Name=attachment.vpc-id,Values='$vpc | grep VpnGatewayId
    aws ec2 describe-network-interfaces --region $region --filters 'Name=vpc-id,Values='$vpc | grep NetworkInterfaceId
    aws ec2 describe-carrier-gateways --region $region --filters Name=vpc-id,Values=$vpc | grep CarrierGatewayId
    aws ec2 describe-local-gateway-route-table-vpc-associations --region $region --filters Name=vpc-id,Values=$vpc | grep LocalGatewayRouteTableVpcAssociationId
}