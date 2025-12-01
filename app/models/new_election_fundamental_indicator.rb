class NewElectionFundamentalIndicator < ApplicationRecord

  CANDIDATE_META = {

    2014 => {
      1 => {
        "CLARA LOPEZ" => {
          party_code: 1,
          party_name: "POLO DEMOCRATICO ALTERNATIVO PDA UNION PATRIOTICA UP",
          candidate_code: 1
        },
        "MARTHA LUCIA RAMIREZ" => {
          party_code: 2,
          party_name: "PARTIDO CONSERVADOR COLOMBIANO",
          candidate_code: 2
        },
        "JUAN MANUEL SANTOS CALDERON" => {
          party_code: 3,
          party_name: "UNIDAD NACIONAL",
          candidate_code: 3
        },
        "ENRIQUE PEÑALOSA" => {
          party_code: 4,
          party_name: "PARTIDO ALIANZA VERDE",
          candidate_code: 4
        },
        "OSCAR IVAN ZULUAGA" => {
          party_code: 5,
          party_name: "CENTRO DEMOCRATICO MANO FIRME CORAZON GRANDE",
          candidate_code: 5
        }
      },

      2 => {
        "JUAN MANUEL SANTOS CALDERON" => {
          party_code: 1,
          party_name: "UNIDAD NACIONAL",
          candidate_code: 1
        },
        "OSCAR IVAN ZULUAGA" => {
          party_code: 2,
          party_name: "CENTRO DEMOCRATICO MANO FIRME CORAZON GRANDE",
          candidate_code: 2
        }
      }
    },

    2018 => {
      1 => {
        "IVAN DUQUE" => {
          party_code: 12,
          party_name: "PARTIDO CENTRO DEMOCRATICO",
          candidate_code: 1
        },
        "VIVIANE MORALES" => {
          party_code: 14,
          party_name: "PARTIDO SOMOS",
          candidate_code: 2
        },
        "JORGE ANTONIO TRUJILLO SARMIENTO" => {
          party_code: 16,
          party_name: "MOVIMIENTO POLITICO TODOS SOMOS COLOMBIA",
          candidate_code: 3
        },
        "HUMBERTO DE LA CALLE" => {
          party_code: 25,
          party_name: "COALICION PAR. LIBERAL COLOMBIANO PAR. ALIANZA SOCIAL INDEPENDIENTE ASI",
          candidate_code: 4
        },
        "SERGIO FAJARDO" => {
          party_code: 26,
          party_name: "COALICION COLOMBIA",
          candidate_code: 5
        },
        "GERMAN VARGAS LLERAS" => {
          party_code: 27,
          party_name: "COALICION #MEJOR VARGAS LLERAS ANTE TODO COLOMBIA",
          candidate_code: 6
        },
        "PROMOTORES VOTO EN BLANCO" => {
          party_code: 28,
          party_name: "PARTIDO DE REIVINDICACION ETNICA \"PRE\"",
          candidate_code: 7
        },
        "GUSTAVO PETRO" => {
          party_code: 29,
          party_name: "COALICION PETRO PRESIDENTE",
          candidate_code: 8
        }
      },

      2 => {
        "IVAN DUQUE" => {
          party_code: 12,
          party_name: "PARTIDO CENTRO DEMOCRATICO",
          candidate_code: 1
        },
        "GUSTAVO PETRO" => {
          party_code: 29,
          party_name: "COALICION PETRO PRESIDENTE",
          candidate_code: 8
        }
      }
    },

    2022 => {
      1 => {
        "JOHN MILTON RODRIGUEZ" => {
          party_code: 14,
          party_name: "COLOMBIA JUSTA LIBRES",
          candidate_code: 2
        },
        "ENRIQUE GOMEZ MARTINEZ" => {
          party_code: 302,
          party_name: "PARTIDO MOVIMIENTO DE SALVACION NACIONAL",
          candidate_code: 5
        },
        "INGRID BETANCOURT" => {
          party_code: 304,
          party_name: "PARTIDO VERDE OXIGENO",
          candidate_code: 8
        },
        "LUIS PEREZ" => {
          party_code: 527,
          party_name: "COLOMBIA PIENSA EN GRANDE",
          candidate_code: 7
        },
        "RODOLFO HERNANDEZ" => {
          party_code: 1076,
          party_name: "LIGA DE GOBERNANTES ANTICORRUPCION",
          candidate_code: 1
        },
        "SERGIO FAJARDO" => {
          party_code: 1233,
          party_name: "COALICION CENTRO ESPERANZA",
          candidate_code: 4
        },
        "FEDERICO GUTIERREZ" => {
          party_code: 1234,
          party_name: "COALICION EQUIPO POR COLOMBIA",
          candidate_code: 3
        },
        "GUSTAVO PETRO" => {
          party_code: 1235,
          party_name: "COALICION PACTO HISTORICO",
          candidate_code: 6
        }
      },

      2 => {
        "RODOLFO HERNANDEZ" => {
          party_code: 1076,
          party_name: "LIGA DE GOBERNANTES ANTICORRUPCION",
          candidate_code: 1
        },
        "GUSTAVO PETRO" => {
          party_code: 1235,
          party_name: "COALICION PACTO HISTORICO",
          candidate_code: 2
        }
      }
    },

    :general => {
      "VOTOS EN BLANCO" => {
        party_code: 996,
        party_name: "VOTOS EN BLANCO",
        candidate_code: 996
      },
      "VOTOS NULOS" => {
        party_code: 997,
        party_name: "VOTOS NULOS",
        candidate_code: 997
      },
      "VOTOS NO MARCADOS" => {
        party_code: 998,
        party_name: "VOTOS NO MARCADOS",
        candidate_code: 998
      }
    }

  }

  def meta_for(candidate_name)
    yr = election_year.to_i
    rd = voting_round.to_i

    meta = CANDIDATE_META.dig(yr, rd, candidate_name)
    meta ||= CANDIDATE_META[:general][candidate_name] rescue nil
    meta
  end

end

