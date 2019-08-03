ActiveAdmin.register Donation do
  permit_params :date, :user_id, :donation_type_id

  index do
    selectable_column
    id_column
    column :date
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :date
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :date, as: :datepicker
      f.input :user_id, as: :select, collection: User.pluck(:email, :id), label: 'User'
      f.input :donation_type_id, as: :select, collection: DonationType.pluck(:name, :id), label: 'Type'
    end
    f.actions
  end

end
