#
# Copyright 2025 LSEG & Microsoft. All rights reserved.
#

locals {
  # Disk Encryption Set Key Configuration
  expiration_date = timeadd(timestamp(), "8760h") # 1 year from now
  key_size        = 2048
  key_type        = "RSA"
}
