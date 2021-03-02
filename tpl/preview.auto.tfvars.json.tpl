{
	"aws_region": "us-west-2",
	"assume_role": "DPSTerraformRole",
	"account_id": "{{ twdps/di/svc/aws/dps-2/aws-account-id }}",
	"instance_type": "db.r4.large",
	"engine_version": "10.12",
	"cluster_name": "preview",
	"domain": "twdps.io",
	"domain_account": "{{ twdps/di/svc/aws/dps-1/aws-account-id }}"
}