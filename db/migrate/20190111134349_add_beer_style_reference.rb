class AddBeerStyleReference < ActiveRecord::Migration[5.2]
  def change
    add_reference :beers, :styles, index: true

    reversible do
      Style.all.each do |style|
        Beer.where(old_style: style.name).each do |beer|
          beer.styles_id = style.id
          beer.save!
        end
      end
    end
  end
end
