#########################################
# ALB
#########################################
resource "aws_lb" "main" {
    name               = "${var.project_name}-alb"
    load_balancer_type = "application"
    internal           = false
    security_groups    = [var.public_sg_id]
    subnets            = var.subnets_public

    tags = {
        Name = "${var.project_name}-alb"
    }
}

#########################################
# Target Group
#########################################
resource "aws_lb_target_group" "tg" {
    name     = "${var.project_name}-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}

#########################################
# Listener
#########################################
resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.main.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
}
