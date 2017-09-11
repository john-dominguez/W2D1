class Employee

  def initialize(name='jeb')
    @name = name
    @title = 'dish washer'
    @salary = 50_000
    @boss = nil
  end

  def bonus(multi)
    @bonus = (@salary) * multi
    @bonus
  end

end

class Manager < Employee
  def initialize(name='john')
    super(name)
    @employees = []
  end

  def bonus(multi)
    @bonus = @employees.reduce(0) do |bonus, employee|
      bonus += employee.bonus(multi)
    end
    @bonus *= multi
    @bonus
  end

  def add_employee(employees)
    employees.each do |employee|
      @employees << employee
    end
  end

end


ed = Employee.new
sed = Employee.new
fed = Employee.new
ded = Employee.new


red = Manager.new
red.add_employee([ed,sed,fed,ded])
p red.bonus(0.15)
