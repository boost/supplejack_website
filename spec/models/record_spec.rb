# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

# encoding: UTF-8

RSpec.describe Record do
  let(:image_url) {'http://test.url'}
  let(:large_image_url) {'http://large.url'}
  let(:record) {described_class.new(thumbnail_url: image_url, landing_url: 'dummy', large_thumbnail_url: large_image_url)}

  def test_size(url, expected_size)
    actual_size = url.match(/#{Regexp.escape(THUMBNAIL_SERVER_URL)}\/\?resize=([0-9]+)&src=.*/).captures.first

    expect(actual_size).to eq(expected_size.to_s)
  end

  describe "#image_url" do
    it "returns the thumbnail address for the Records image" do
      expect(record.image_url).to eq("#{THUMBNAIL_SERVER_URL}/?resize=204&src=#{CGI.escape(large_image_url)}")
    end

    it "sets the size parameter to 204 by default" do
      test_size(record.image_url, 204)
    end

    it "passes the size parameter through to the thumbnailer" do
      test_size(record.image_url(width: 500), 500)
    end

    it "does not resize the image if original parameter is truthy" do
      expect(record.image_url(original: true)).not_to match(/size/)
    end
  end
end
