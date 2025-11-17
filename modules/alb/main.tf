resource "aws_lb" "app" {
    name               = "${var.project_name}-alb"
    load_balancer_type = "application"
    subnets            = var.public_subnets
}

resource "aws_lb_target_group" "tg" {
    name     = "${var.project_name}-tg"
    port     = var.target_group_port
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.app.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
}

resource "aws_security_group_rule" "alb_to_nodes" {
    type              = "ingress"
    from_port         = var.target_group_port
    to_port           = var.target_group_port
    protocol          = "tcp"
    security_group_id = var.eks_nodes_sg_id
    cidr_blocks       = ["0.0.0.0/0"]
}
