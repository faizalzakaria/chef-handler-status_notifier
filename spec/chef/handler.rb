class Chef::Handler
  class RunStatus
    def failed?
      true
    end

    def formatted_exception
      "formatted exception"
    end
  end

  class Node
    def name
      "node"
    end
  end

  def run_status
    @run_status ||= RunStatus.new
  end

  def node
    @node ||= Node.new
  end
end
