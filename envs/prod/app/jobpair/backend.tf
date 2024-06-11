terraform {
    backend "s3" {
        bucket = "jobpair-tfstate-01"
        key = "jobpair/prod/jobpair_v1.0.0.tfstate"
        region = "ap-northeast-1"
    }
}
