class KudoPolicy
  attr_reader :employee, :kudo

  def initialize(employee, kudo)
    @employee = employee
    @kudo = kudo
  end

  def update?
    Time.current - kudo.created_at < 5.minutes
  end

  def edit?
    update?
  end

  def destroy?
    Time.current - kudo.created_at < 5.minutes
  end

  class Scope
    def initialize(employee, scope)
      @employee = employee
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :employee, :scope
  end
end
