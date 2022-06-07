from ortools.linear_solver import pywraplp as p

def test(s: str):
  print(f'Solver: {s}')
  solver = p.Solver.CreateSolver(s)

  x = solver.NumVar(0, 1, 'x')
  y = solver.NumVar(0, 2, 'y')

  print('Number of variables =', solver.NumVariables())

  ct = solver.Constraint(0, 2, 'ct')
  ct.SetCoefficient(x, 1)
  ct.SetCoefficient(y, 1)

  print('Number of constraints =', solver.NumConstraints())

  objective = solver.Objective()
  objective.SetCoefficient(x, 3)
  objective.SetCoefficient(y, 1)
  objective.SetMaximization()

  solver.Solve()

  print('Solution:')
  print('Objective value =', objective.Value())
  print('x =', x.solution_value())
  print('y =', y.solution_value())

  assert x.solution_value() == 1.0
  assert y.solution_value() == 1.0

test('SCIP')
test('GLPK')
