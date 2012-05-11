class String

  def strip_heredoc
    indent = scan(%r/^[ \t]*(?=\S)/).min.size rescue 0
    gsub(%r/^[ \t]{#{indent}}/, '')
  end

end