class Enigma
  def initialize(encoder, encrypter, decrypter)
    @encoder = encoder
    @encrypter = encrypter
    @decrypter = decrypter
  end

  def encrypt(message, key = nil, date = nil)
    key = @encoder.get_random_five_digit_number_array.join unless key
    date, shifts = get_date_and_shifts(key, date)
    encrypted = @encrypter.encrypt(message, shifts)

    {encryption: encrypted, key: key, date: date}
  end

  def decrypt(ciphertext, key, date = nil)
    date, shifts = get_date_and_shifts(key, date)
    decrypted = @decrypter.decrypt(ciphertext, shifts)

    {decryption: decrypted, key: key, date: date}
  end

  def get_date_and_shifts(key, date)
    date = @encoder.in_DD_MM_YY(Time.now) unless date
    shifts = @encoder.generate_shifts(key, date).values
    return date, shifts
  end
end
