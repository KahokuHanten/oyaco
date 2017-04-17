class PrefName

  def self.get_pref_name(pref_id)
    pref = JpPrefecture::Prefecture.find pref_id
    pref.name
  end

  def self.get_pref_id(pref_name)
    pref = JpPrefecture::Prefecture.find(name: pref_name)
    pref.code.to_s
  end

end
