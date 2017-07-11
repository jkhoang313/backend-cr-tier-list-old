class Auth
  ALGORITHM = 'HS256'

  def self.encrypt(hash)
    JWT.encode(hash, secret_key, ALGORITHM)
  end

  def self.decode(jwt)
    JWT.decode(jwt, secret_key, true, {algorithm: ALGORITHM}).first
  end

  def self.secret_key
    "8D63BB0B20FD9B9103F21461CD789C663E47CB126FB945766273AB51C93E4FF2"
  end
end
