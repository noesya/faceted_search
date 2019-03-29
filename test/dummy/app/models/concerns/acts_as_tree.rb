module ActsAsTree
  extend ActiveSupport::Concern

  included do

    def root?
      !has_parent?
    end

    def has_parent?
      parent.present?
    end

    def has_children?
      children.exists?
    end

    def ancestors
      has_parent? ? parent.ancestors.push(parent) : []
    end

    def descendents
      has_children? ? children.map { |child| [child, child.descendents].flatten }.flatten : []
    end

    def ancestors_and_self
      ancestors.push self
    end

    def name_with_ancestors
      ancestors_and_self.join ' / '
    end

    def siblings
      self.class.where(parent: parent)
                .where.not(id: id)
    end

  end
end