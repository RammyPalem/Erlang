gateway service

{
  "Resources": {
    "AWSService": {
      "Type": "AWS::ElasticLoadBalancingV2::LoadBalancer",
      "Properties": {
        "Name": "AWSServiceLoadBalancer",
        "Scheme": "internet-facing",
        "Type": "application",
        "Subnets": [
          "subnet-12345678",
          "subnet-87654321"
        ],
        "SecurityGroups": [
          "sg-aws-12345678"
        ]
      }
    },
    "TargetGroupBWS": {
      "Type": "AWS::ElasticLoadBalancingV2::TargetGroup",
      "Properties": {
        "Name": "TargetGroupBWS",
        "Port": 443,
        "Protocol": "HTTPS",
        "VpcId": "vpc-internal-12345678"
      }
    },
    "TargetGroupCWS": {
      "Type": "AWS::ElasticLoadBalancingV2::TargetGroup",
      "Properties": {
        "Name": "TargetGroupCWS",
        "Port": 443,
        "Protocol": "HTTPS",
        "VpcId": "vpc-internal-12345678"
      }
    },
    "TargetGroupDWS": {
      "Type": "AWS::ElasticLoadBalancingV2::TargetGroup",
      "Properties": {
        "Name": "TargetGroupDWS",
        "Port": 443,
        "Protocol": "HTTPS",
        "VpcId": "vpc-internal-12345678"
      }
    },
    "Listener": {
      "Type": "AWS::ElasticLoadBalancingV2::Listener",
      "Properties": {
        "LoadBalancerArn": {
          "Ref": "AWSService"
        },
        "Port": 443,
        "Protocol": "HTTPS",
        "DefaultActions": [
          {
            "Type": "Forward",
            "TargetGroupArn": {
              "Ref": "TargetGroupBWS"
            }
          }
        ]
      }
    }
  },
  "Outputs": {
    "AWSServiceLoadBalancerDNS": {
      "Value": {
        "Fn::GetAtt": [
          "AWSService",
          "DNSName"
        ]
      }
    }
  }
}