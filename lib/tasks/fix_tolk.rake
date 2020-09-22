namespace 'tolk' do
  desc "fix bug in reset db after import"
  task 'seed' => :environment do
    Tolk::Phrase.all.each do |phrase|
      begin
        phrase.translations.primary.text
      rescue Exception => e
        l = Tolk::Locale.where(name: (ENV['DEFAULT_LOCALE'] || 'en')).first
        t = phrase.translations.where(locale: l).first_or_initialize(text: "NYI")
        t.save!
      end
    end
  end
end