//
// Generated by JTB 1.1.2
//

package jde.parser.syntaxtree;

/**
 * Grammar production:
 * <PRE>
 * f0 -> LabeledStatement()
 *       | Block()
 *       | EmptyStatement()
 *       | StatementExpression() ";"
 *       | SwitchStatement()
 *       | IfStatement()
 *       | WhileStatement()
 *       | DoStatement()
 *       | ForStatement()
 *       | BreakStatement()
 *       | ContinueStatement()
 *       | ReturnStatement()
 *       | ThrowStatement()
 *       | SynchronizedStatement()
 *       | TryStatement()
 * </PRE>
 */
public class Statement implements Node {
   public NodeChoice f0;

   public Statement(NodeChoice n0) {
      f0 = n0;
   }

   public void accept(jde.parser.visitor.Visitor v) {
      v.visit(this);
   }
}
