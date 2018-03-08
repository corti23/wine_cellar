class Bottle < ApplicationRecord
  belongs_to :user
  
  enum colour: [:blanc,
                :blanc_effervescent,
                :blanc_liquoreux,
                :blanc_moelleux,
                :blanc_sec,
                :rose,
                :rose_effervescent,
                :rouge,
                :rouge_effervescent,
                :rouge_liquoreux,
                :rouge_moelleux,
                :rouge_sec]
  
  enum format: [:bouteille,
                :magnum,
                :double_magnum,
                :jeroboam3l,
                :jeroboam5l,
                :demi,
                :autre]
  
  validates :user_id, presence: true
  validates :appellation, presence: true, length: { maximum: 30 }
  
end
