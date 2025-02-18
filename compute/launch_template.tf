resource "aws_launch_template" "ass10_lt" {
    name = "ass10-lt"
    image_id = var.image_id
    instance_type = var.instance_type
    key_name = "pmk-own-labs"
    iam_instance_profile {
        name = aws_iam_instance_profile.ssm_instance_profile.name
    }
    vpc_security_group_ids = [var.web_sg_id]
    user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              service nginx start

              # Set a unique background color for each instance
              COLOR="#$(openssl rand -hex 3)"  # Generates a random hex color code
              echo "<html>
                    <body style='background-color: $${COLOR};'>
                    <h1>Welcome to the Load Balancer Test</h1>
                    <p>This instance has a unique background color.</p>
                    </body>
                    </html>" > /usr/share/nginx/html/index.html
              EOF
    )
}