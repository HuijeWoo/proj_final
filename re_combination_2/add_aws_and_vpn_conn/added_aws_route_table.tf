<<<<<<< HEAD

resource "aws_route_table_association" "RouteAndSub1" {
    subnet_id      = aws_subnet.subnet1.id
    route_table_id = data.aws_route_table.rt.id
=======
resource "aws_route_table" "routetable1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name = "${var.aws_prefix}_routetable"
    } 
    lifecycle {
        create_before_destroy = true
    }
}
resource "aws_route_table_association" "RouteAndSub1" {
    subnet_id      = aws_subnet.subnet1.id
    route_table_id = aws_route_table.routetable1.id
>>>>>>> b66ab7998d37aebe3d3ca438b5ec6b669aa9f44c
    lifecycle {
        create_before_destroy = true
    }
}