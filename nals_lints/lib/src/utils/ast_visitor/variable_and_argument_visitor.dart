import '../../index.dart';

class VariableAndArgumentVisitor extends GeneralizingAstVisitor<void> {
  void Function(InstanceCreationExpression node) onVisitInstanceCreationExpression;
  void Function(NamedExpression node) onVisitNamedExpression;
  void Function(VariableDeclaration node) onVisitVariableDeclaration;
  void Function(AssignmentExpression node) onVisitAssignmentExpression;
  void Function(ConstructorFieldInitializer node) onVisitConstructorFieldInitializer;
  void Function(SuperConstructorInvocation node) onVisitSuperConstructorInvocation;
  void Function(ConstructorDeclaration node) onVisitConstructorDeclaration;

  VariableAndArgumentVisitor({
    required this.onVisitInstanceCreationExpression,
    required this.onVisitNamedExpression,
    required this.onVisitVariableDeclaration,
    required this.onVisitAssignmentExpression,
    required this.onVisitConstructorFieldInitializer,
    required this.onVisitSuperConstructorInvocation,
    required this.onVisitConstructorDeclaration,
  });

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    onVisitInstanceCreationExpression(node);

    // Recursively visit nested InstanceCreationExpression nodes
    node.visitChildren(this);
  }

  @override
  void visitNamedExpression(NamedExpression node) {
    onVisitNamedExpression(node);

    // Recursively visit nested NamedExpression nodes
    node.visitChildren(this);
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    onVisitVariableDeclaration(node);

    // Recursively visit nested VariableDeclaration nodes
    node.visitChildren(this);
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    onVisitAssignmentExpression(node);

    // Recursively visit nested AssignmentExpression nodes
    node.visitChildren(this);
  }

  @override
  void visitConstructorFieldInitializer(ConstructorFieldInitializer node) {
    onVisitConstructorFieldInitializer(node);

    // Recursively visit nested ConstructorFieldInitializer nodes
    node.visitChildren(this);
  }

  @override
  void visitSuperConstructorInvocation(SuperConstructorInvocation node) {
    onVisitSuperConstructorInvocation(node);

    // Recursively visit nested SuperConstructorInvocation nodes
    node.visitChildren(this);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    onVisitConstructorDeclaration(node);

    // Recursively visit nested ConstructorDeclaration nodes
    node.visitChildren(this);
  }
}
