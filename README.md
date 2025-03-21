# PostgreSQL Streaming Replication Setup with Ansible & Terraform

This project automates the creation of **two cloud servers** and configures **PostgreSQL streaming and logical replication** between them using **Terraform** and **Ansible**.

## Key Features

-  **Terraform**: Provision two EC2 instances and generate a dynamic Ansible `inventory.ini` file.
-  **PostgreSQL**: Automatically installed and configured on both servers.
-  **Streaming Replication**: Configured using `pg_basebackup`, replication slots, and `pg_hba.conf`.
-  **Logical Replication**: Sets up a second PostgreSQL cluster and configures `PUBLICATION` / `SUBSCRIPTION` for logical replication.
-  **Replication Check**: Automatic verification ensures replication is working as expected.

---

## Requirements

- **Terraform** ≥ 1.0
- **Ansible** ≥ 2.10
- **AWS CLI & credentials** configured (`~/.aws/credentials` or environment variables)
- **SSH key pair** (public/private) to connect to EC2 instances

---

## Step-by-Step Setup

### Run Terraform First

Navigate to the `terraform/` directory:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Terraform will:

- Create two EC2 instances
- Generate the inventory.ini file for Ansible in the ../ansible/ directory
After Terraform completes, check ansible/inventory.ini — it’s ready to use.

### Run Ansible Playbook

Navigate to the Ansible folder and launch configuration:

```bash
cd ../ansible
ansible-playbook -i inventory.ini playbooks/playbook.yml
```

Ansible will:

- Install PostgreSQL on both servers
- Configure the primary as a replication source
- Configure the replica using pg_basebackup
- Start both servers and initiate streaming replication
- Set up logical replication by:
  - Creating a second PostgreSQL cluster on the replica (port 5433)
  - Creating PUBLICATION on primary and SUBSCRIPTION on the logical replica
  - Creating matching table structures

## Replication Check

Once the infrastructure and PostgreSQL configuration are complete, the playbook automatically performs verification steps for both streaming and logical replication to ensure everything is working correctly.

### Streaming Replication Test

The playbook verifies that the streaming replication between primary and replica servers is functioning properly:

1. **On the Primary Server**:
    - Queries `pg_stat_replication` to check if any replica is connected and receiving data.

2. **On the Replica Server**:
    - Confirms that the server is in **recovery mode** (`pg_is_in_recovery()` returns `true`)
    - Inserts a test row on the primary server into `example_table`
    - Waits briefly, then queries the replica to see if the row was replicated
    - Displays the replication status:
      ```
      Found 1 matching rows on replica. Streaming Replication SUCCESSFUL
      ```

### Logical Replication Test

The playbook also performs a full test of logical replication using a second PostgreSQL cluster running on the replica server (port 5433):

1. **On the Primary Server**:
   - Inserts a new test row (logical_test) into example_table (which is part of the example_publication)

2. **Logical Replica Cluster**:
   - Waits briefly to receive the data via SUBSCRIPTION
   - Queries the replicated example_table on port 5433
   - Displays a message with the result:
     ```
     Logical Replication SUCCESSFUL
     ```