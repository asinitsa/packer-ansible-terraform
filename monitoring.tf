resource "aws_cloudwatch_metric_alarm" "nlb_healthyhosts" {
  alarm_name          = "BastionIsDown"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Number of healthy nodes in Target Group"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.sns.arn]
  ok_actions          = [aws_sns_topic.sns.arn]
  dimensions = {
    TargetGroup  = aws_lb_target_group.bastion-ssh.arn_suffix
    LoadBalancer = aws_lb.bastion.arn_suffix
  }
}

resource "aws_sns_topic" "sns" {
  name = "user-updates-topic"
}