# Helper methods for parsing XML.
module XmlParsingHelper
  # @param path [String] Xpath query to find the node in XML.
  # @param attribute [Symbol] Attribute on the node to call and return as the value.
  # @param xml [Nokogiri::XML] A nokogiri parser object to call #xpath.
  # @param nil_value (optional) A value to return if the attribute on the node
  # is nil or if the node is not present.
  #
  # @return [String] Value from an attribute of an xpath node, if present.
  # If the node is not present, return nil or nil_value if specified.
  def xpath_if_present(path, attribute, xml, nil_value = nil)
    text = xml.xpath(path).first.send(attribute) unless xml.xpath(path).empty?
    text ||= nil_value
  end
end
