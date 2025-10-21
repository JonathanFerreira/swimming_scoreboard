module ApplicationHelper
  include Pagy::Frontend

  # Helper customizado para paginação com Tailwind CSS
  def pagy_tailwind_nav(pagy, pagy_id: nil, link_extra: '', **vars)
    return '' unless pagy.pages > 1

    pagy_id = %(<div id="#{pagy_id}">) if pagy_id
    html = %(<nav class="flex items-center justify-center space-x-1 mt-6"#{pagy_id ? '' : " id=\"#{pagy_id}\""}>)
    html << pagy_tailwind_nav_prev(pagy, link_extra: link_extra, **vars)
    html << pagy_tailwind_nav_pages(pagy, link_extra: link_extra, **vars)
    html << pagy_tailwind_nav_next(pagy, link_extra: link_extra, **vars)
    html << %(</nav>)
    html << %(</div>) if pagy_id
    html.html_safe
  end

  # Helper para paginação compacta (mobile-friendly)
  def pagy_tailwind_nav_compact(pagy, pagy_id: nil, link_extra: '', **vars)
    return '' unless pagy.pages > 1

    pagy_id = %(<div id="#{pagy_id}">) if pagy_id
    html = %(<nav class="flex items-center justify-center space-x-1 mt-6"#{pagy_id ? '' : " id=\"#{pagy_id}\""}>)
    html << pagy_tailwind_nav_prev(pagy, link_extra: link_extra, **vars)
    html << pagy_tailwind_nav_pages_compact(pagy, link_extra: link_extra, **vars)
    html << pagy_tailwind_nav_next(pagy, link_extra: link_extra, **vars)
    html << %(</nav>)
    html << %(</div>) if pagy_id
    html.html_safe
  end

  private

  def pagy_tailwind_nav_prev(pagy, link_extra: '', **vars)
    if (p_prev = pagy.prev)
      %(<a href="#{pagy_url_for(pagy, p_prev, **vars)}" class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-l-md hover:bg-gray-50 hover:text-gray-700 transition-colors duration-200"#{pagy.vars[:link_extra]} #{link_extra}>#{pagy_t('pagy.nav.prev')}</a>)
    else
      %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-300 bg-gray-100 border border-gray-300 rounded-l-md cursor-not-allowed">#{pagy_t('pagy.nav.prev')}</span>)
    end
  end

  def pagy_tailwind_nav_next(pagy, link_extra: '', **vars)
    if (p_next = pagy.next)
      %(<a href="#{pagy_url_for(pagy, p_next, **vars)}" class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-r-md hover:bg-gray-50 hover:text-gray-700 transition-colors duration-200"#{pagy.vars[:link_extra]} #{link_extra}>#{pagy_t('pagy.nav.next')}</a>)
    else
      %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-300 bg-gray-100 border border-gray-300 rounded-r-md cursor-not-allowed">#{pagy_t('pagy.nav.next')}</span>)
    end
  end

  def pagy_tailwind_nav_pages(pagy, link_extra: '', **vars)
    html = ''
    pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << case item
              when Integer # page number
                if item == pagy.page
                  %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-white bg-blue-600 border border-blue-600">#{item}</span>)
                else
                  %(<a href="#{pagy_url_for(pagy, item, **vars)}" class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 hover:bg-gray-50 hover:text-gray-700 transition-colors duration-200"#{pagy.vars[:link_extra]} #{link_extra}>#{item}</a>)
                end
              when String # current page
                %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-white bg-blue-600 border border-blue-600">#{item}</span>)
              when :gap # page gap
                %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300">#{pagy_t('pagy.nav.gap')}</span>)
              end
    end
    html
  end

  def pagy_tailwind_nav_pages_compact(pagy, link_extra: '', **vars)
    html = ''
    # Mostra apenas algumas páginas para mobile
    if pagy.pages <= 7
      pagy.series.each do |item|
        html << case item
                when Integer
                  if item == pagy.page
                    %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-white bg-blue-600 border border-blue-600">#{item}</span>)
                  else
                    %(<a href="#{pagy_url_for(pagy, item, **vars)}" class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 hover:bg-gray-50 hover:text-gray-700 transition-colors duration-200"#{pagy.vars[:link_extra]} #{link_extra}>#{item}</a>)
                  end
                when String
                  %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-white bg-blue-600 border border-blue-600">#{item}</span>)
                when :gap
                  %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300">#{pagy_t('pagy.nav.gap')}</span>)
                end
      end
    else
      # Versão compacta para muitas páginas
      html << %(<span class="inline-flex items-center px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300">#{pagy.page} / #{pagy.pages}</span>)
    end
    html
  end
end
