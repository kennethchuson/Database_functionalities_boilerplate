const userSchema = new mongoose.Schema({
    name: {
      type: String,
      required: true
    },
    is_deleted: {
      type: Boolean,
      default: false
    }
  });
  
  const blueCardSchema = new mongoose.Schema({
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true
    },
    image: {
      type: Buffer,
      required: true
    },
    name: {
      type: String,
      required: true
    },
    description: String
  });
  
  const redCardSchema = new mongoose.Schema({
    video: {
      type: Buffer,
      required: true
    }
  });
  
  const greenCardSchema = new mongoose.Schema({
    blue_card_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'BlueCard'
    },
    red_card_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'RedCard'
    },
    text: {
      type: String,
      default: 'NONE'
    }
  });
  
  const User = mongoose.model('User', userSchema);
  const BlueCard = mongoose.model('BlueCard', blueCardSchema);
  const RedCard = mongoose.model('RedCard', redCardSchema);
  const GreenCard = mongoose.model('GreenCard', greenCardSchema);
  