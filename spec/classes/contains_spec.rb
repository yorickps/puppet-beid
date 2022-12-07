# frozen_string_literal: true

require 'spec_helper'

describe 'beid' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with default values' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('beid') }
        it { is_expected.to contain_class('beid::install').that_comes_before('Class[beid::service]') }
        it { is_expected.to contain_class('beid::service') }
      end
    end
  end
end
