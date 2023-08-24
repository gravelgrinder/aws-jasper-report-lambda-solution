### Consumer Account Resources
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}




###############################################################################
### Create DynamoDB Tables
###############################################################################
resource "aws_dynamodb_table" "ReportDefinitions" {
  name           = "ReportDefinitions"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ReportId"

  attribute {
    name = "ReportId"
    type = "S"
  }


  tags = {
    Name        = "ReportDefinitions"
    Environment = "dev"
  }
}


resource "aws_dynamodb_table_item" "MyFirstReport" {
  table_name = aws_dynamodb_table.ReportDefinitions.name
  hash_key   = aws_dynamodb_table.ReportDefinitions.hash_key

  item = <<ITEM
{
    "ReportId": {"S": "0001"},
    "ReportName": {"S": "MyFirstReport"},
    "ExecutionType": {"S": "OnDemand"},
    "ExecutionFrequency": {"S": "*/5 * * * *"},
    "Enabled": {"S": "true"},
    "ReportDefinitionPath": {"S": "s3://{s3InputBucket}/reportDefinitions/MyFirstReport.jrxml"},
    "Parameters": {"S": ""},
    "ReportOutputPath": {"S": "s3://{s3OutputBucket}/ARISE/"},
    "ReportOutputFileType": {"S": "PDF"},
    "ReportOutputFileName": {"S": "MyFirstReport.pdf"},
    "Status": {"S": "Stopped"},
    "RunStart": {"S": ""},
    "RunStop": {"S": ""},
    "Errors": {"S": ""},
    "CreationDate": {"S": ""}
}
ITEM
}