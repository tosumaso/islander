class Evaluation < ActiveHash::Base
    self.data = [
      {id: 1, name: '---------'},
      {id: 2, name: '1(悪い)'},
      {id: 3, name: '2(微妙)'},
      {id: 4, name: '3(普通)'},
      {id: 5, name: '4(良い)'},
      {id: 6, name: '5(とても良い)'}
    ]
    include ActiveHash::Associations
    has_many :posts
end
