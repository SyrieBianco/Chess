class Employee
 attr_reader :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

end

class Manager < Employee
attr_accessor :employees

  def initialize(name, title, salary, boss, employees = [])
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    employee_salary_sum * multiplier
  end

  def employee_salary_sum
    sum = 0
    @employees.each { |em| sum += em.salary }
  end

end


ned = Manager.new('Ned', 'Founder', 1000000, nil)
darren = Manager.new('Darren', 'TA Manager', 78000, ned)
shawna = Employee.new('Shawna', 'TA', 12000, darren)
david = Employee.new('David', 'TA', 10000, darren)

darren.employees += [shawna, david]
ned.employees << darren

p ned.bonus(5) == 500000
p darren.bonus(4) == 88000
p david.bonus(3) == 30000
